package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro;

import android.app.Service;
import android.content.Intent;
import android.os.Binder;
import android.os.Bundle;
import android.os.IBinder;
import android.support.annotation.Nullable;

import com.android.volley.Cache;
import com.android.volley.Network;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.BasicNetwork;
import com.android.volley.toolbox.DiskBasedCache;
import com.android.volley.toolbox.HurlStack;
import com.android.volley.toolbox.JsonObjectRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.fragments.Songs;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Song;

/**
 * Created by ios_developer on 23/05/2017.
 */

public final class SongsDownloader extends Service {

    public class SongsBinder extends Binder {

        private final SongsDownloader downloader;

        public SongsBinder(SongsDownloader downloader) {

            this.downloader = downloader;
        }

        public SongsDownloader getDownloader() {

            return downloader;
        }
    }

    private IBinder binder = null;
    private RequestQueue requestQueue = null;

    private final Response.Listener<JSONObject> responseListener = new Response.Listener<JSONObject>() {

        @Override
        public void onResponse(JSONObject response) {

            try {

                if(response.has("genre")) {

                    String genre = response.getString("genre");

                    if (response.has("featured_tracks")) {

                        JSONArray tracks = response.getJSONArray("featured_tracks");

                        int count = tracks.length();

                        for (int i = 0; i < count; i++) {

                            JSONObject track = tracks.getJSONObject(i);

                            if (track.has("artist") &&
                                    track.has("name") &&
                                    track.has("stream") &&
                                    track.has("published") &&
                                    track.has("img_small") &&
                                    track.has("img_large")) {

                                final Song song = new Song(track.getString("artist"),
                                        track.getString("name"),
                                        track.getString("stream"),
                                        track.getString("published"),
                                        track.getString("img_small"),
                                        track.getString("img_large"));

                                sendSong(song, genre);
                            }
                        }
                    }
                }
            } catch (JSONException ignored) {}
        }
    };

    private final Response.ErrorListener errorListener = new Response.ErrorListener() {

        @Override
        public void onErrorResponse(VolleyError error) {

        }
    };

    @Override
    public void onCreate() {
        super.onCreate();

        binder = new SongsBinder(this);

        Cache cache = new DiskBasedCache(getCacheDir(), 1024 * 1024);
        Network network = new BasicNetwork(new HurlStack());
        requestQueue = new RequestQueue(cache, network);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {

        if(intent != null) {

            Bundle extras = intent.getExtras();

            if(extras != null) {

                String url = extras.getString(Songs.class.getName());
                addRequestUrl(url);

                requestQueue.start();
            }
        }

        return Service.START_STICKY;
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {

        return binder;
    }

    @Override
    public boolean onUnbind(Intent intent) {

        requestQueue.stop();

        return super.onUnbind(intent);
    }

    private void addRequestUrl(String url) {

        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                url,
                null,
                responseListener,
                errorListener);

        requestQueue.add(request);
    }

    private void sendSong(Song song, String genre) {

        Bundle bundle = new Bundle();
        bundle.putParcelable(Song.class.getName(), song);

        Intent intent = new Intent();
        intent.setAction(genre);
        intent.putExtras(bundle);

        sendBroadcast(intent);
    }
}

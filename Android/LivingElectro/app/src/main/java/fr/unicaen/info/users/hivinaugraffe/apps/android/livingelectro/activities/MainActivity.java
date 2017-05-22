package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.activities;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

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

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.R;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters.PartsAdapter;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Part;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Song;

/**
 * Created by ios_developer on 21/05/2017.
 */

public final class MainActivity extends AppCompatActivity {

    private TabLayout tabLayout = null;
    private ViewPager viewPager = null;
    private PartsAdapter adapter = null;
    private RequestQueue requestQueue = null;

    private final Response.Listener<JSONObject> responseListener = new Response.Listener<JSONObject>() {

        @Override
        public void onResponse(JSONObject response) {

            try {

                if(response.has("genre")) {

                    final Part part = new Part(response.getString("genre"));

                    if(response.has("featured_tracks")) {

                        JSONArray tracks = response.getJSONArray("featured_tracks");

                        int count = tracks.length();

                        for(int i = 0; i < count; i++) {

                            JSONObject track = tracks.getJSONObject(i);

                            if(track.has("artist") &&
                                    track.has("name") &&
                                    track.has("stream") &&
                                    track.has("published") &&
                                    track.has("img_small") &&
                                    track.has("img_large")) {

                                Song song = new Song(track.getString("artist"),
                                        track.getString("name"),
                                        track.getString("stream"),
                                        track.getString("published"),
                                        track.getString("img_small"),
                                        track.getString("img_large"));

                                part.addSong(song);
                            }
                        }
                    }

                    MainActivity.this.runOnUiThread(new Runnable() {

                        @Override
                        public void run() {

                            adapter.addPart(part);
                        }
                    });
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    };

    private final Response.ErrorListener errorListener = new Response.ErrorListener() {

        @Override
        public void onErrorResponse(VolleyError error) {

        }
    };

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.main_activity);

        tabLayout = (TabLayout) findViewById(R.id.tablayout);
        viewPager = (ViewPager) findViewById(R.id.viewPager);

        /*
        ((ImageView) findViewById(R.id.imageView)).setImageBitmap(decodeSampledBitmapFromResource(getResources(),
                R.drawable.app_background,
                100,
                100));
                */
    }

    @Override
    protected void onPostCreate(@Nullable Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

        adapter = new PartsAdapter(getSupportFragmentManager());

        Cache cache = new DiskBasedCache(getCacheDir(), 1024 * 1024);
        Network network = new BasicNetwork(new HurlStack());
        requestQueue = new RequestQueue(cache, network);

        addRequestUrl("http://m.livingelectro.com/m/Electro/0");
        addRequestUrl("http://m.livingelectro.com/m/House/0");
        addRequestUrl("http://m.livingelectro.com/m/Dubstep/0");
        addRequestUrl("http://m.livingelectro.com/m/Trance/0");
    }

    @Override
    protected void onResume() {
        super.onResume();

        viewPager.setAdapter(adapter);
        tabLayout.setupWithViewPager(viewPager, true);

        requestQueue.start();
    }

    @Override
    protected void onPause() {
        super.onPause();

        viewPager.setAdapter(null);
        tabLayout.setupWithViewPager(null);

        requestQueue.stop();
    }

    private void addRequestUrl(String url) {

        JsonObjectRequest request = new JsonObjectRequest(Request.Method.GET,
                url,
                null,
                responseListener,
                errorListener);

        requestQueue.add(request);
    }

    public Bitmap decodeSampledBitmapFromResource(Resources res, int resId,
                                                         int reqWidth, int reqHeight) {

        // First decode with inJustDecodeBounds=true to check dimensions
        final BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(res, resId, options);

        // Calculate inSampleSize
        options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

        // Decode bitmap with inSampleSize set
        options.inJustDecodeBounds = false;
        return BitmapFactory.decodeResource(res, resId, options);
    }

    public int calculateInSampleSize(
            BitmapFactory.Options options, int reqWidth, int reqHeight) {
        // Raw height and width of image
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {

            final int halfHeight = height / 2;
            final int halfWidth = width / 2;

            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while ((halfHeight / inSampleSize) >= reqHeight
                    && (halfWidth / inSampleSize) >= reqWidth) {
                inSampleSize *= 2;
            }
        }

        return inSampleSize;
    }
}

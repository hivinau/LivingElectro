package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.fragments;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.R;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.SongsDownloader;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters.SongsAdapter;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Part;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Song;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class Songs extends Fragment {

    private RecyclerView recyclerView = null;
    private SongsAdapter adapter = null;
    private IntentFilter filter = null;
    private String genre = null;

    private BroadcastReceiver songReceiver = new BroadcastReceiver() {

        @Override
        public void onReceive(Context context, Intent intent) {

            if(intent != null) {

                String genre = intent.getAction();

                if(genre.equals(Songs.this.genre)) {

                    Bundle extras = intent.getExtras();

                    if(extras != null) {

                        final Song song = extras.getParcelable(Song.class.getName());

                        getActivity().runOnUiThread(new Runnable() {

                            @Override
                            public void run() {

                                adapter.addSong(song);
                            }
                        });
                    }
                }
            }
        }
    };

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.songs_fragment, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        recyclerView = (RecyclerView) view.findViewById(R.id.recyclerView);
    }

    @Override
    public void onActivityCreated(@Nullable Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        adapter = new SongsAdapter();

        Bundle arguments = getArguments();

        if(arguments != null) {

            String genre = arguments.getString(Part.class.getName());

            if(genre != null && !genre.isEmpty()) {

                this.genre = genre; //use to be a reference when song is sent as broacast message by songsDownloader service

                filter = new IntentFilter();
                filter.addAction(genre);

                String requestUrl = String.format("http://m.livingelectro.com/m/%s/0", genre);

                Bundle bundle = new Bundle();
                bundle.putString(Songs.class.getName(), requestUrl);

                Intent intent = new Intent(getActivity(), SongsDownloader.class);
                intent.putExtras(bundle);

                getActivity().startService(intent);
            }
        }
    }

    @Override
    public void onStart() {
        super.onStart();

        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        recyclerView.setLayoutManager(layoutManager);
    }

    @Override
    public void onResume() {
        super.onResume();

        recyclerView.setAdapter(adapter);
        getActivity().registerReceiver(songReceiver, filter);
    }

    @Override
    public void onStop() {
        super.onStop();

        recyclerView.setLayoutManager(null);
    }

    @Override
    public void onPause() {
        super.onPause();

        recyclerView.setAdapter(null);
        getActivity().unregisterReceiver(songReceiver);
    }
}

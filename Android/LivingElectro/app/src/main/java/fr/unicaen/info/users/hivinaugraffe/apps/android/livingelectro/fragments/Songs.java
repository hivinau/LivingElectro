package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.fragments;

import android.os.Bundle;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.R;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters.SongsAdapter;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Song;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class Songs extends Fragment {

    private RecyclerView recyclerView = null;
    private SongsAdapter adapter = null;

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

            Parcelable[] songs = arguments.getParcelableArray(Song.class.getName());

            if(songs != null && songs.length > 0) {

                for (Parcelable song : songs) {

                    if(song instanceof Song) {

                        adapter.addSong((Song) song);
                    }
                }
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
    }
}

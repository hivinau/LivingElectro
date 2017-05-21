package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Song;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class SongsAdapter extends RecyclerView.Adapter<SongsAdapter.ViewHolder> {

    private final List<Song> songs;

    public SongsAdapter(List<Song> songs) {

        this.songs = songs;
    }

    public boolean addSong(Song song) {

        boolean state = songs.add(song);

        notifyDataSetChanged();

        return state;
    }

    public boolean removeSong(Song song) {

        boolean state = songs.remove(song);

        notifyDataSetChanged();

        return state;
    }

    public void removeAllSongs() {

        songs.clear();
        notifyDataSetChanged();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return null;
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {

    }

    @Override
    public int getItemCount() {
        return 0;
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        public ViewHolder(View itemView) {
            super(itemView);
        }
    }
}

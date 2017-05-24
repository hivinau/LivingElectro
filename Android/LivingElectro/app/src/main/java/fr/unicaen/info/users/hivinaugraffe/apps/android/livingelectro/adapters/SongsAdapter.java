package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.R;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Song;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class SongsAdapter extends RecyclerView.Adapter<SongsAdapter.ViewHolder> {

    private final List<Song> songs;

    public SongsAdapter() {

        this.songs = new ArrayList<>();
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
    public int getItemCount() {

        return songs.size();
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {

        LayoutInflater inflater = LayoutInflater.from(parent.getContext());

        View view = inflater.inflate(R.layout.song, parent, false);

        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {

        if(position < songs.size()) {

            Song song = songs.get(position);

            Picasso.with(holder.imageView.getContext())
                    .load(song.getImageLarge())
                    .placeholder(R.drawable.placeholder)
                    .into(holder.imageView);

            holder.textView.setText(song.getName());
        }
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        public final ImageView imageView;
        public final TextView textView;

        public ViewHolder(View itemView) {
            super(itemView);

            imageView = (ImageView) itemView.findViewById(R.id.imageView);
            textView = (TextView) itemView.findViewById(R.id.textView);
        }
    }
}

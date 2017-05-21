package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class Part implements Parcelable {

    private final String genre;
    private final Set<Song> songs;

    public static final Creator<Part> CREATOR = new Creator<Part>() {
        @Override
        public Part createFromParcel(Parcel in) {
            return new Part(in);
        }

        @Override
        public Part[] newArray(int size) {
            return new Part[size];
        }
    };

    public Part(String genre) {
        this.genre = genre;
        this.songs = new HashSet<>();
    }

    protected Part(Parcel in) {
        genre = in.readString();
        songs = new HashSet<>();

        Object[] songs = in.readArray(Song.class.getClassLoader());

        for (Object song : songs) {

            if(song instanceof Song) {

                addSong((Song) song);
            }
        }
    }

    public String getGenre() {
        return genre;
    }

    public Song[] getSongs() {

        return songs.toArray(new Song[songs.size()]);
    }

    public boolean addSongs(Collection<Song> songs) {

        return this.songs.addAll(songs);
    }

    public boolean addSong(Song song) {

        return songs.add(song);
    }

    public boolean removeSongs(Collection<Song> songs) {

        return this.songs.removeAll(songs);
    }

    public boolean removeSong(Song song) {

        return songs.remove(song);
    }

    @Override
    public int describeContents() {

        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {

        dest.writeString(genre);
        dest.writeArray(getSongs());
    }
}

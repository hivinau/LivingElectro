package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models;

import android.os.Parcel;
import android.os.Parcelable;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class Song implements Parcelable {

    private final String artiste;
    private final String name;
    private final String stream;
    private final String published;
    private final String imageSmall;
    private final String imageLarge;

    public static final Creator<Song> CREATOR = new Creator<Song>() {
        @Override
        public Song createFromParcel(Parcel in) {
            return new Song(in);
        }

        @Override
        public Song[] newArray(int size) {
            return new Song[size];
        }
    };

    public Song(String artiste, String name, String stream, String published, String imageSmall, String imageLarge) {
        this.artiste = artiste;
        this.name = name;
        this.stream = stream;
        this.published = published;
        this.imageSmall = imageSmall;
        this.imageLarge = imageLarge;
    }

    protected Song(Parcel in) {
        artiste = in.readString();
        name = in.readString();
        stream = in.readString();
        published = in.readString();
        imageSmall = in.readString();
        imageLarge = in.readString();
    }

    public String getArtiste() {
        return artiste;
    }

    public String getName() {
        return name;
    }

    public String getStream() {
        return stream;
    }

    public String getPublished() {
        return published;
    }

    public String getImageSmall() {
        return imageSmall;
    }

    public String getImageLarge() {
        return imageLarge;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {

        dest.writeString(artiste);
        dest.writeString(name);
        dest.writeString(stream);
        dest.writeString(published);
        dest.writeString(imageSmall);
        dest.writeString(imageLarge);
    }
}

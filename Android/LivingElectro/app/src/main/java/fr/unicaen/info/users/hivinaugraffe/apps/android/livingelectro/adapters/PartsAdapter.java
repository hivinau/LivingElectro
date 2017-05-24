package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

import java.util.ArrayList;
import java.util.List;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.fragments.Songs;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Part;

/**
 * Created by ios_developer on 21/05/2017.
 */

public class PartsAdapter extends FragmentStatePagerAdapter {

    private final List<Part> parts;

    public PartsAdapter(FragmentManager fm) {
        super(fm);

        parts = new ArrayList<>();
    }

    public boolean addPart(Part part) {

        boolean state = parts.add(part);

        notifyDataSetChanged();

        return state;
    }

    public boolean removePart(Part part) {

        boolean state = parts.remove(part);

        notifyDataSetChanged();

        return state;
    }

    public void removeAllParts() {

        parts.clear();
        notifyDataSetChanged();
    }

    @Override
    public Fragment getItem(int position) {

        Bundle arguments = new Bundle();

        Part part = parts.get(position);
        arguments.putString(Part.class.getName(), part.getGenre());

        Songs songs = new Songs();
        songs.setArguments(arguments);

        return songs;
    }

    @Override
    public int getCount() {
        return parts.size();
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return parts.get(position).getGenre();
    }
}

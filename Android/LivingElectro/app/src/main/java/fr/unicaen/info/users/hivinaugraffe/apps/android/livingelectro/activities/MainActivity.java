package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.activities;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.support.annotation.Nullable;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.R;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.SongsDownloader;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.adapters.PartsAdapter;
import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.models.Part;

/**
 * Created by ios_developer on 21/05/2017.
 */

public final class MainActivity extends AppCompatActivity {

    private TabLayout tabLayout = null;
    private ViewPager viewPager = null;
    private PartsAdapter adapter = null;
    private boolean songsDownloaderBinded = false;

    private ServiceConnection songsDownloaderConnection = new ServiceConnection() {

        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {

            songsDownloaderBinded = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {

            songsDownloaderBinded = false;
        }
    };

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.main_activity);

        tabLayout = (TabLayout) findViewById(R.id.tablayout);
        viewPager = (ViewPager) findViewById(R.id.viewPager);
    }

    @Override
    protected void onPostCreate(@Nullable Bundle savedInstanceState) {
        super.onPostCreate(savedInstanceState);

        adapter = new PartsAdapter(getSupportFragmentManager());

        String[] genres = getResources().getStringArray(R.array.genres);

        for (String genre : genres) {

            adapter.addPart(new Part(genre));
        }
    }

    @Override
    protected void onResume() {
        super.onResume();

        viewPager.setAdapter(adapter);
        tabLayout.setupWithViewPager(viewPager, true);

        Intent intent = new Intent(MainActivity.this, SongsDownloader.class);
        bindService(intent, songsDownloaderConnection, Context.BIND_AUTO_CREATE);
    }

    @Override
    protected void onPause() {
        super.onPause();

        viewPager.setAdapter(null);
        tabLayout.setupWithViewPager(null);

        if(songsDownloaderBinded) {

            unbindService(songsDownloaderConnection);
        }
    }
}

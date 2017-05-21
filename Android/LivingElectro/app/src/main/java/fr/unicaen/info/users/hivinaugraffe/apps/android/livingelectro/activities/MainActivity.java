package fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.activities;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.design.widget.TabLayout;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;

import fr.unicaen.info.users.hivinaugraffe.apps.android.livingelectro.R;

/**
 * Created by ios_developer on 21/05/2017.
 */

public final class MainActivity extends AppCompatActivity {

    private TabLayout tabLayout = null;
    private ViewPager viewPager = null;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.main_activity);

        tabLayout = (TabLayout) findViewById(R.id.tablayout);
        viewPager = (ViewPager) findViewById(R.id.viewPager);
    }

    @Override
    protected void onResume() {
        super.onResume();

        tabLayout.setupWithViewPager(viewPager, true);
    }

    @Override
    protected void onPause() {
        super.onPause();

        viewPager.setAdapter(null);
        tabLayout.setupWithViewPager(null);
    }
}

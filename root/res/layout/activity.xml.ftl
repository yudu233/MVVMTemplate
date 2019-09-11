<?xml version="1.0" encoding="utf-8"?>
<layout xmlns:android="http://schemas.android.com/apk/res/android">

    <data>

        <variable
            name="activity"
            type="${ativityPackageName}.${pageName}Activity" />
    </data>

    <androidx.constraintlayout.widget.ConstraintLayout
        android:layout_width="match_parent"
        android:layout_height="match_parent">


        <androidx.coordinatorlayout.widget.CoordinatorLayout
            android:layout_width="match_parent"
            android:layout_height="match_parent">


        </androidx.coordinatorlayout.widget.CoordinatorLayout>

    </androidx.constraintlayout.widget.ConstraintLayout>
</layout>
<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class WorkExperience extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('work_experience', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('language_id')->unsigned();
            $table->foreign('language_id')->references('id')->on('language')->onDelete('cascade');
            $table->integer('company_id')->unsigned();
            $table->foreign('company_id')->references('id')->on('instance')->onDelete('cascade');
            $table->integer('person_id')->unsigned();
            $table->foreign('person_id')->references('id')->on('persons')->onDelete('cascade');
            $table->longText('description')->nullable();
            $table->timestamp('start_date');
            $table->timestamp('end_date')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('work_experience');
    }
}

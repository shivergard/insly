<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Clients extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('persons', function(Blueprint $table) {
            $table->increments('id');
            $table->string('first_name');
            $table->string('last_name');
            $table->timestamp('birth_date');
            $table->integer('person_ident')->index();
            $table->integer('creator_id')->unsigned();
            $table->boolean('is_employee');
            $table->string('email')->unique();
            $table->string('phone_number');
            $table->timestamps();
        });

        Schema::table('persons', function($table) {
           $table->foreign('creator_id')->references('id')->on('system_users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migration.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('persons');
    }
}

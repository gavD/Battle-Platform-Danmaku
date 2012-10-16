Battle Platform Danmaku
=======================

Battle Platform Danmaku is a Bullet Curtain style game engine for ActionScript.

Requires an .FLA to build. The FLA should contain a stage, and symbol implementations
of all the enemy and bullet classes.

This game is the game developed to use gavD's Danmake engine https://github.com/gavD/danmaku-engine

Written in ActionScript 3

Checking it out
---------------

There are a few submodules, so you might want to do something like:

  git clone git@github.com:gavD/Battle-Platform-Danmaku.git
  git submodule init
  git submodule update
  
Structure
---------

src/uk/co/gavd/danmakuengine is a submodule that is the [engine](https://github.com/gavD/danmaku-engine). This is open
sourced and I'm cool with you using it so long as you open source your project also. It has the main documentation for
creating games using the danmaku engine (or it will have! I've only just started writing the docs and we're only just
starting putting assets into the first game!).
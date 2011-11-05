import uk.co.gavd.enemies.*;

// TODO refactor into an object
var fcEnemies:Object = {

    scoreIndex: 0,
    arEnemies: new Array(),
    
    killAll: function():void {
        theRoot.fcGameOver.readyForRestart = true;
        trace("*** REMOVE ALL AMMO " + theRoot.fcBullets); 
        theRoot.fcBullets.killAll = true;
        for(var i:Number = 0; i < this.arEnemies.length; i++) {
            var tmp = this.arEnemies[i];
            trace("KILL ENEMY " + tmp);
            theRoot.absDelete(tmp);
		}
        this.arEnemies = new Array();
    },
    
    registerEnemy: function (ptr:Enemy):void {
        /*
		// let's see if we can put it in an existing place
        var spaceFound:Boolean = false;
        for(var i:Number = 0; i < this.arEnemies.length; i++) {
            if (this.arEnemies[i].x == undefined) {
                trace("Put in at " + i);
                this.arEnemies[i] = ptr;
                spaceFound = true;
                break;
            }
        }

        // chuck it on the end of the array
        if (!spaceFound) {
            if (this.arEnemies.length >= theRoot.MAX_ENEMIES) {
                trace("ALREADY HAVE " + theRoot.MAX_ENEMIES + " enemies, BLAMMING");
                theRoot.absDelete(ptr);
            } else {
                this.arEnemies.push(ptr);
            }
        }
		*/
    },
    /*
    detectHits: function(bullet:MovieClip):void {
        for (var i:Number = 0; i < this.arEnemies.length; i++) {
            var ptr:MovieClip = this.arEnemies[i];
        
      		(ptr.x == undefined) { 
                continue;
            }
            else if (ptr.lAction == Enemy.DYING) {
                continue;
            }
            
            //trace("Hit zone test on " + bullet.hitZone + " vs " + ptr);
            if (bullet.hitZone.hitTest(ptr)) {
                theRoot.hud.mobileHud.scoreCounter.comboMeter.comboUp();
                bullet.gotoAndPlay("explode");
                bullet.triggered = true;
                if(ptr.takeHit) {
                    ptr.takeHit();
                } else {
                    this.kill(ptr);
                }
            }
        }
    }
    
    ,
	kill: function(ptr:MovieClip):void {
        ptr.lAction = Enemy.DYING;
        var scoreUp:Number = (ptr.scoreForKill * theRoot.hud.mobileHud.scoreCounter.comboMeter.multiplier);
        theRoot.score += scoreUp;
        var mcTmp:MovieClip = theRoot.game.BGMid.scoreFloaterTemplate.duplicateMovieClip("score" + this.scoreIndex, theRoot.game.BGMid.getNextHighestDepth());
        //var mcTmp:MovieClip = eval("theRoot.game.BGMid.score" + this.scoreIndex);
        this.scoreIndex++; // TODO can remove?
        mcTmp.x = ptr.x;
        mcTmp.y = ptr.y;
        mcTmp.score = scoreUp;
        ptr.gotoAndPlay("die");
    },
    
    getDistanceFromHeroRaw: function (ptr:MovieClip):Number {
        return (theRoot.game.hero.x - theRoot.game.BGMid.x) - ptr.x
    },
    
    getDistanceFromHero: function (ptr:MovieClip):Number {
        return Math.abs(this.getDistanceFromHeroRaw(ptr));
    },
    
    applyBounceInner: function (enemy:MovieClip, bounceScaleFactor:Number):void {
        var heroX:Number = theRoot.game.hero.x - theRoot.game.BGMid.x;
        
        var inertia:Number = 9 * bounceScaleFactor;
        var inertiaXMod:Number = 0;
        var inertiaYMod:Number = 0;
        
        if (heroX < enemy.x) {
            inertiaXMod = inertia;
        } else if (heroX > enemy.x) {
            inertiaXMod = inertia * -1;
        }
        
        if (theRoot.game.hero.y < enemy.y) {
            inertiaYMod = inertia * -1;
        } else if (theRoot.game.hero.y > enemy.y) {
            inertiaYMod = inertia;
        }
        //trace("Apply bounce inner " + enemy + ":" + inertiaXMod + ";" + inertiaYMod);
        
        theRoot.game.hero.lInertiaX += inertiaXMod;
        theRoot.game.hero.lInertiaY += inertiaYMod;        
    },
    
    applyBounce: function (enemy:MovieClip, bounceScaleFactor:Number):void {
        var heroX:Number = theRoot.game.hero.x - theRoot.game.BGMid.x;
        if (Math.abs(heroX - enemy.x) < (enemy._width / 2)
         && Math.abs(theRoot.game.hero.y - enemy.y) < (enemy._height / 2))
        {
            this.applyBounceInner(enemy, bounceScaleFactor);
        }
    },
    
    doFrame: function():void {
        if (theRoot.bGamePaused) { return; }
        
        for (var i:Number = 0; i < this.arEnemies.length; i++) {
            var tmp:MovieClip = this.arEnemies[i];

            if(this.arEnemies[i].x == undefined) {
                continue;
            }
            this.arEnemies[i].process();
            this.applyBounce(this.arEnemies[i], this.arEnemies[i].xScaleFactor);
        }
        theRoot.fcBullets.killAll = false; // TODO?
    }
	*/
	stuff: 1
}

package uk.co.gavd.ballistics {
	import uk.co.gavd.Game;
	
    public class BulletSlow extends Bullet {
    	public function BulletSlow(game:Game) {
			super(game);
			
			this.lSpeed = 2;
			this.damage = 5;
		}
    }
}
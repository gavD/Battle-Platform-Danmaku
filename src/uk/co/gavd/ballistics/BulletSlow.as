package uk.co.gavd.ballistics {
	import uk.co.gavd.Game;
	
    public class BulletSlow extends Bullet {
    	public function BulletSlow(game:Game) {
			super(game);
			
			this.lSpeed = 1.5;
			this.damage = 5;
		}
    }
}
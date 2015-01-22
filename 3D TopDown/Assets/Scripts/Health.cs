using UnityEngine;
using System.Collections;

public class Health : MonoBehaviour {

	public GameObject explosion;
	public float health = 100f;
	public Texture2D healthBarTexture;
	
	// Update is called once per frame
	void Update () {
		if (health < 0) {
			if (explosion)
				Instantiate (explosion, transform.position, transform.rotation);

			if (transform.gameObject.tag == "Player")
				Application.LoadLevel("Scene 1");
			else {
				if (transform.gameObject.tag == "EnemyTank" && GameObject.FindGameObjectsWithTag ("EnemyTank").Length <= 1)
					Application.LoadLevel("Scene 1");
				Destroy( this.gameObject );
			}
		}
	}

	public void TakeDamage (float amount) {
		health -= amount;
	}

	/*void OnGUI ()
	{
		GUI.HorizontalScrollbar(Rect (0,40,200,20), 0, (maxHealth / 200) * health,0, 100);
	}*/

	void OnGUI() {
		if (gameObject.tag == "Player") {
			GUI.DrawTexture (new Rect (10, 10, (health/960) * 200, 10), healthBarTexture);
		}
	}
}

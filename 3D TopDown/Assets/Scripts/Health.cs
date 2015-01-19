using UnityEngine;
using System.Collections;

public class Health : MonoBehaviour {

	public GameObject explosion;
	public float health = 100f;
	
	// Update is called once per frame
	void Update () {
		if (health < 0) {
			Instantiate (explosion, transform.position, transform.rotation);
			Destroy( this.gameObject );
		}
	}

	public void TakeDamage (float amount) {
		health -= amount;
	}
}

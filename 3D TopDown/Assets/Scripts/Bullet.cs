using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {

	public float floatSpeed = 30f;
	public float duration = 10f;

	public float damage = 30f;
	public float damageRadius = 3f;

	public GameObject explosion;
	
	public Health[] healthObj;

	// Use this for initialization
	void Start () {
		healthObj = gameObject.GetComponents<Health>();
		Destroy (this.gameObject, duration);
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		duration -= Time.deltaTime;
		if (duration <= 0)
			Destroy (this.gameObject);

		transform.Translate (-Vector3.forward * floatSpeed * Time.deltaTime);
	}

	void OnTriggerEnter () {
		Instantiate (explosion, transform.position, transform.rotation);

		Collider[] colliders = Physics.OverlapSphere (transform.position, damageRadius);

		foreach (Collider col in colliders) {
			Health health = col.GetComponentInParent<Health>();
			if (health) {
				float distance = Vector3.Distance (transform.position, col.transform.position);
				float damageRatio = 1f - (distance / damageRadius);

				health.TakeDamage (damage * damageRatio);
			}
		}

		Destroy (this.gameObject);
	}
}

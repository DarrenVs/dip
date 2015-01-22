using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {

	public float floatSpeed = 30f;
	public float maxDuration = 10f;
	float duration;

	public float damage = 30f;
	public float damageRadius = 3f;

	public GameObject explosion;
	
	public Health[] healthObj;

	GameObject bulletTarget;

	// Use this for initialization
	void Start () {
		duration = maxDuration;

		healthObj = gameObject.GetComponents<Health>();

		Destroy (this.gameObject, duration);
	}

	public void SetTarget(GameObject target) {
		bulletTarget = target;
	}
	
	// Update is called once per frame
	void FixedUpdate () {
		duration -= Time.deltaTime;
		if (duration <= 0)
			Destroy (this.gameObject);

		transform.Translate (-Vector3.forward * floatSpeed * Time.deltaTime);
	}

	void OnTriggerEnter () {
		if (duration < maxDuration -0.1f) {
			Instantiate (explosion, transform.position, transform.rotation);

			Collider[] colliders = Physics.OverlapSphere (transform.position, damageRadius);

			foreach (Collider col in colliders) {

				Health health = col.GetComponentInParent<Health>();
				if (health) {
					float distance = Vector3.Distance (transform.position, col.transform.position);
					float damageRatio = 1f - (distance / damageRadius);

					if (distance <= damageRadius && bulletTarget && health && col.transform.parent == bulletTarget.transform)
						health.TakeDamage (damage * damageRatio);
					else if (distance <= damageRadius && !bulletTarget && health)
						health.TakeDamage (damage * damageRatio);
				}
			}
		}
		Destroy (this.gameObject);
	}
}

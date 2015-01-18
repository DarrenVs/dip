using UnityEngine;
using System.Collections;

public class Bullet : MonoBehaviour {

	public float floatSpeed = 1f;
	public float duration = 0f;

	public GameObject explosion;

	// Use this for initialization
	void Start () {
		
		Destroy (this.gameObject, duration);
	}
	
	// Update is called once per frame
	void Update () {
		duration -= Time.deltaTime;
		if (duration <= 0)
			Destroy (this.gameObject);

		transform.Translate (-Vector3.forward * floatSpeed * Time.deltaTime);
	}

	void OnTriggerEnter () {
		Instantiate (explosion, transform.position, transform.rotation);
		Destroy (this.gameObject);
	}
}

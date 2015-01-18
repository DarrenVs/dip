using UnityEngine;
using System.Collections;

public class PlayerCam : MonoBehaviour {
	private GameObject target;

	// Use this for initialization
	void Start () {
		target = GameObject.FindWithTag ("Player");
	}
	
	// Update is called once per frame
	void Update () {
		transform.position = target.transform.position + target.transform.forward * -3 + new Vector3 (0, 2, 0);
		transform.LookAt ( target.transform.position );
	}
}

using UnityEngine;
using System.Collections;

public class SelfDestruct : MonoBehaviour {
	public float duration = 3;

	// Use this for initialization
	void Start () {
		Destroy (this.gameObject, duration);
	}
}

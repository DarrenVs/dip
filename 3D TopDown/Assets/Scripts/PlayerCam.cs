using UnityEngine;
using System.Collections;

public class PlayerCam : MonoBehaviour {
	private GameObject target;
	
	public float maxZoomOffset;
	
	float zoomOffset;

	// Use this for initialization
	void Start () {
		target = GameObject.FindWithTag ("Player");

		zoomOffset = maxZoomOffset;
	}
	
	// Update is called once per frame
	void Update () {
		if (target) {
			transform.position = target.transform.position + target.transform.forward * (-5 - zoomOffset) + new Vector3 (0, zoomOffset, 0);
			transform.LookAt (target.transform.position);
			transform.position += transform.up * 3;
		}

		if (zoomOffset - Input.mouseScrollDelta.y > 0 && zoomOffset - Input.mouseScrollDelta.y < maxZoomOffset) {
			zoomOffset -= Input.mouseScrollDelta.y;
		}
	}

	void OnGUI() {
		GUI.TextArea (new Rect (10, 400, 100, 20), "Enemys left: " + GameObject.FindGameObjectsWithTag ("EnemyTank").Length);
	}
}

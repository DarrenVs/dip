using UnityEngine;
using System.Collections;

public class AntiRoll : MonoBehaviour {
	public float maxAngle = 22.5f;
	
	// Update is called once per frame
	void Update () {
		
		Vector3 force = new Vector3 (0, 0, 0);
		
		if (transform.rotation.eulerAngles.x > maxAngle && transform.rotation.eulerAngles.x < 360f - maxAngle)
		{
			if (transform.rotation.eulerAngles.x < 180f)
				force += transform.right * -(transform.rotation.eulerAngles.x - maxAngle);
			else
				force += transform.right * -(transform.rotation.eulerAngles.x + maxAngle - 360f);
		}
		if (transform.rotation.eulerAngles.z > maxAngle && transform.rotation.eulerAngles.z < 360f - maxAngle)
		{
			if (transform.rotation.eulerAngles.z < 180f)
				force += transform.forward * -(transform.rotation.eulerAngles.z - maxAngle);
			else
				force += transform.forward * -(transform.rotation.eulerAngles.z + maxAngle - 360f);
		}
		
		if (force.x != 0 || force.z != 0 || force.y != 0)
		{
			rigidbody.angularVelocity = force + new Vector3 ( 0, rigidbody.angularVelocity.y, 0 );
		}
	}
}

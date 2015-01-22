using UnityEngine;
using System.Collections;

public class Movement : MonoBehaviour {
	Transform baseTank;

	float moveSpeed;
	float rotateSpeed;
	float colliding;

	public float collisionResistance;
	
	// Use this for initialization
	void Start () {
		
		baseTank = transform.FindChild ("TankBase");
	}

	// Colission
	void OnCollisionEnter (Collision col)
	{
		++colliding;
	}
	void OnCollisionExit (Collision col)
	{
		--colliding;
	}

	public void SetMovementSpeed (float amount) {
		moveSpeed = amount;
	}
	public void SetRotateSpeed (float amount) {
		rotateSpeed = amount;
	}

	public void AddMovementSpeed (float amount) {
		moveSpeed += amount;
	}
	public void AddRotateSpeed (float amount) {
		rotateSpeed += amount;
	}

	public float GetMovementSpeed () {
		return moveSpeed;
	}
	public float GetRotationSpeed () {
		return rotateSpeed;
	}
	
	// Update is called once per frame
	void Update () {
		// Custom Velocity
		// Update CoordinateFrames
		transform.Translate (Vector3.forward * moveSpeed * Time.deltaTime);
		transform.Rotate (Vector3.up * rotateSpeed * Time.deltaTime);
		
		// Update custom velocity1
		rotateSpeed -= rotateSpeed / collisionResistance;
		
		if (colliding > 0)
		{
			// Update custom velocity2
			moveSpeed -= moveSpeed / collisionResistance;
		} else {
			rigidbody.angularVelocity = new Vector3 (rigidbody.angularVelocity.x, 0, rigidbody.angularVelocity.z);
		}
		// End of Custom Velocity

		// Running in to a wall check
		RaycastHit colliderHit;
		Ray colliderRay = new Ray (baseTank.position, baseTank.forward);

		if (Physics.Raycast (colliderRay, out colliderHit, 1))
			moveSpeed = 0f;
		// End of wall check
	}
}

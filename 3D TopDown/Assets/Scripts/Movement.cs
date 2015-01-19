using UnityEngine;
using System.Collections;

public class Movement : MonoBehaviour {

	float moveSpeed;
	float rotateSpeed;
	float colliding;

	public float collisionResistance;

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
		}
		// End of Custom Velocity
	}
}

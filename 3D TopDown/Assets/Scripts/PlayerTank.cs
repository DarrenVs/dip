using UnityEngine;
using System.Collections;

public class PlayerTank : MonoBehaviour {
	Transform baseTank;
	Transform turret;
	Transform barrle;

	public GameObject bulletPrefab;

	float moveSpeed = 0;
	float rotateSpeed = 0;
	int colliding = 0;

	// Use this for initialization
	void Start () {
		
		baseTank = transform.FindChild ("TankBase");
		turret = transform.FindChild ("TankTurret");
		barrle = turret.FindChild ("TurretBarrle");
		//rigidbody.AddForce (new Vector3 ( 0, -0.001f, 0 ));
	}

	void OnCollisionEnter (Collision col)
	{
		++colliding;
	}
	void OnCollisionExit (Collision col)
	{
		--colliding;
	}
	
	// Update is called once per frame
	void Update () {

		// Custom Velocity
		// Update CoordinateFrames
		transform.Translate (Vector3.forward * moveSpeed * Time.deltaTime);
		transform.Rotate (Vector3.up * rotateSpeed * Time.deltaTime);

		// Update custom velocity1
		rotateSpeed -= rotateSpeed / 10;

		if (colliding > 0)
		{
			// Update custom velocity2
			moveSpeed -= moveSpeed / 10;
			
			// KeyInput
			if (Input.GetKey (KeyCode.UpArrow)) {
				moveSpeed += 1f;
			}
			if (Input.GetKey (KeyCode.DownArrow)) {
				moveSpeed -= 1f;
			}
			if (Input.GetKey (KeyCode.RightArrow)) {
				rotateSpeed += 25f;
			}
			if (Input.GetKey (KeyCode.LeftArrow)) {
				rotateSpeed -= 25f;
			}
		}
		// End of Custom Velocity



		// Running in to a wall check
		RaycastHit colliderHit;
		Ray colliderRay = new Ray (baseTank.position, baseTank.forward * moveSpeed);

		if (Physics.Raycast (colliderRay, out colliderHit, 1))
			moveSpeed = 0f;
		// End of wall check



		// Anti roll --using angularVelocity Force
		Vector3 force = new Vector3 (0, 0, 0);

		if (transform.rotation.eulerAngles.x > 22.5f && transform.rotation.eulerAngles.x < 337.5f)
		{
			if (transform.rotation.eulerAngles.x < 180)
				force += transform.right * -(transform.rotation.eulerAngles.x - 22.5f);
			else
				force += transform.right * -(transform.rotation.eulerAngles.x + 22.5f - 360);
		}
		if (transform.rotation.eulerAngles.z > 22.5f && transform.rotation.eulerAngles.z < 337.5f)
		{
			if (transform.rotation.eulerAngles.z < 180)
				force += transform.forward * -(transform.rotation.eulerAngles.z - 22.5f);
			else
				force += transform.forward * -(transform.rotation.eulerAngles.z + 22.5f - 360);
		}

		if (force.x != 0 || force.z != 0 || force.y != 0)
		{
			rigidbody.angularVelocity = force + new Vector3 ( 0, rigidbody.angularVelocity.y, 0 );
			moveSpeed -= moveSpeed/10;
		}
		// End of Anti toll



		
		// Turret angle
		Ray mouseRay = Camera.main.ScreenPointToRay (Input.mousePosition);

		RaycastHit mouseHit;
		if (Physics.Raycast (mouseRay, out mouseHit, 100))
						turret.LookAt (new Vector3 (mouseHit.point.x, turret.position.y, mouseHit.point.z));
				else
						turret.LookAt (new Vector3 (turret.position.x + mouseRay.direction.x, turret.position.y, turret.position.z + mouseRay.direction.z));
		// End of turret angle
			

		// Fire
		if (Input.GetButtonDown ("Fire1"))
			Instantiate (bulletPrefab, barrle.position + barrle.up * 0.5f, Quaternion.Euler( new Vector3( 0, turret.rotation.eulerAngles.y + 180, 0 ) ) );
	}
}

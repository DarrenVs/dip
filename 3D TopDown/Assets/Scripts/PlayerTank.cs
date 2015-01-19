using UnityEngine;
using System.Collections;

public class PlayerTank : MonoBehaviour {
	Transform baseTank;
	Transform turret;
	Transform barrle;


	public GameObject bulletPrefab;
	Movement moveScript;

	int colliding = 0;

	// Use this for initialization
	void Start () {

		moveScript = transform.GetComponent <Movement> ();
		
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

		if (colliding > 0)
		{
			// KeyInput
			if (Input.GetKey (KeyCode.UpArrow)) {
				moveScript.AddMovementSpeed (1f);
			}
			if (Input.GetKey (KeyCode.DownArrow)) {
				moveScript.AddMovementSpeed (-1f);
			}
			if (Input.GetKey (KeyCode.RightArrow)) {
				moveScript.AddRotateSpeed (25f);
			}
			if (Input.GetKey (KeyCode.LeftArrow)) {
				moveScript.AddRotateSpeed (-25f);
			}
		}
		
		
		// Running in to a wall check
		RaycastHit colliderHit;
		Ray colliderRay = new Ray (baseTank.position, baseTank.forward * moveScript.GetMovementSpeed());

		if (Physics.Raycast (colliderRay, out colliderHit, 1))
			moveScript.SetMovementSpeed (0f);
		// End of wall check

		
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

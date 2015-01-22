using UnityEngine;
using System.Collections;

public class PlayerTank : MonoBehaviour {
	Transform baseTank;
	Transform turret;
	Transform barrle;
	
	Movement moveScript;
	float cooldown;

	public GameObject bulletPrefab;
	public GameObject crossHairPrefab;
	public float moveSpeed = 10f;
	public float rotateSpeed = 25f;
	public float fireRate = 0.3f;
	
	GameObject CrossHairRay;
	Transform crossHair;
	Transform mousePoint;
	LineRenderer crossHairLine;
	LineRenderer mouseLine;

	int colliding = 0;

	// Use this for initialization
	void Start () {

		moveScript = transform.GetComponent <Movement> ();
		
		baseTank = transform.FindChild ("TankBase");
		turret = transform.FindChild ("TankTurret");
		barrle = turret.FindChild ("TurretBarrle");
		cooldown = fireRate;

		CrossHairRay = Instantiate (crossHairPrefab, Vector3.zero, Quaternion.identity) as GameObject;
		crossHair = CrossHairRay.transform.FindChild ("CrossHair");
		crossHairLine = crossHair.FindChild ("CrossHairLine").GetComponent<LineRenderer>();
		mousePoint = CrossHairRay.transform.FindChild ("MousePoint");
		mouseLine = mousePoint.FindChild ("MouseLine").GetComponent<LineRenderer>();
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
			if (Input.GetKey (KeyCode.W)) {
				moveScript.AddMovementSpeed (moveSpeed);
			}
			if (Input.GetKey (KeyCode.S)) {
				moveScript.AddMovementSpeed (-moveSpeed);
			}
			if (Input.GetKey (KeyCode.D)) {
				moveScript.AddRotateSpeed (rotateSpeed);
			}
			if (Input.GetKey (KeyCode.A)) {
				moveScript.AddRotateSpeed (-rotateSpeed);
			}
		}
		
		// Turret angle
		Ray mouseRay = Camera.main.ScreenPointToRay (Input.mousePosition);

		RaycastHit mouseHit;
		if (Physics.Raycast (mouseRay, out mouseHit)) {

			// CrossHair
			RaycastHit corssHairHit;
			Debug.DrawRay(turret.position, mouseHit.point - turret.position);

			if (Physics.Raycast (new Ray(turret.position, mouseHit.point - turret.position), out corssHairHit)) {
				CrossHairRay.SetActive (true);

				crossHairLine.SetPosition (0, turret.position); crossHairLine.SetPosition(1, corssHairHit.point);
				mouseLine.SetPosition (0, corssHairHit.point); mouseLine.SetPosition(1, mouseHit.point);

				crossHair.position = corssHairHit.point;
				if (Vector3.Distance (corssHairHit.point, mouseHit.point) > 0.1f) {
					mousePoint.position = mouseHit.point;
					mousePoint.gameObject.SetActive (true);
				} else
					mousePoint.gameObject.SetActive (false);
			}
			// End of CrossHair

			turret.LookAt (mouseHit.point);

			if (baseTank.localEulerAngles.x + turret.localEulerAngles.x > 7.5f && baseTank.localEulerAngles.x + turret.localEulerAngles.x < 180)
				turret.Rotate (new Vector3 (7.5f-(baseTank.localEulerAngles.x + turret.localEulerAngles.x), 0, 0));

			else if (baseTank.localEulerAngles.x + turret.localEulerAngles.x < 330f && baseTank.localEulerAngles.x + turret.localEulerAngles.x > 180)
				turret.Rotate (new Vector3 (330f-(baseTank.localEulerAngles.x + turret.localEulerAngles.x), 0, 0));
		} else {
			turret.LookAt (turret.position + mouseRay.direction);
			CrossHairRay.SetActive (false);
		}
		
			if (baseTank.localEulerAngles.x + turret.localEulerAngles.x > 7.5f && baseTank.localEulerAngles.x + turret.localEulerAngles.x < 180)
				turret.Rotate (new Vector3 (7.5f-(baseTank.localEulerAngles.x + turret.localEulerAngles.x), 0, 0));
			
			else if (baseTank.localEulerAngles.x + turret.localEulerAngles.x < 330f && baseTank.localEulerAngles.x + turret.localEulerAngles.x > 180)
				turret.Rotate (new Vector3 (330f-(baseTank.localEulerAngles.x + turret.localEulerAngles.x), 0, 0));
		// End of turret angle
			

		// Fire
		cooldown -= Time.deltaTime;
		if (cooldown <= 0 && Input.GetButton ("Fire1")) {
			Instantiate (bulletPrefab, barrle.position + barrle.up * 0.5f, Quaternion.LookRotation (-turret.forward));
			cooldown = fireRate;
		}
	}
}

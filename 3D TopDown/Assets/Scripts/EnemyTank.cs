using UnityEngine;
using System.Collections;

public class EnemyTank : MonoBehaviour {
	Transform baseTank;
	Transform turret;
	Transform barrle;
	
	Movement moveScript;

	public GameObject bulletPrefab;
	public float fireRate = 3;
	public GameObject AItracks;// WIP
	public float floatSpeed = 1;

	int currentTrack = 0;
	int colliding = 0;
	
	float cooldown;
	
	GameObject playerTank;

	GameObject bullet;
	
	// Use this for initialization
	void Start () {

		moveScript = transform.GetComponent <Movement> ();

		playerTank = GameObject.FindGameObjectWithTag ("Player");
		
		baseTank = transform.FindChild ("TankBase");
		turret = transform.FindChild ("TankTurret");
		barrle = turret.FindChild ("TurretBarrle");
		
		cooldown = fireRate;

		if (AItracks) {
			currentTrack = Mathf.RoundToInt(Random.value * AItracks.transform.childCount);
		}
	}
	
	void OnCollisionEnter (Collision col)
	{
		++colliding;
	}
	void OnCollisionExit (Collision col)
	{
		--colliding;
	}

	void AddCurrentTrack (int amount) {
		currentTrack += amount;

		while (currentTrack > AItracks.transform.childCount-1) {
			currentTrack -= AItracks.transform.childCount-1;
		}
		while (currentTrack < 0) {
			currentTrack += AItracks.transform.childCount;
		}
	}
	
	// Update is called once per frame
	void Update () {
		cooldown -= Time.deltaTime;

		if (playerTank) {
			RaycastHit viewHit;
			Ray viewRay = new Ray (turret.position, playerTank.transform.position - turret.position);
		
			if (cooldown <= 0 && Physics.Raycast (viewRay, out viewHit, 100) && viewHit.transform.tag == "Player") {
				cooldown = fireRate;
				turret.LookAt (new Vector3 (playerTank.transform.position.x, turret.position.y, playerTank.transform.position.z));
				bullet = Instantiate (bulletPrefab, barrle.position + barrle.up * 0.5f, Quaternion.LookRotation ((playerTank.transform.position - transform.position) * -1)) as GameObject;
				bullet.GetComponent<Bullet>().SetTarget(playerTank);
			}
		}

		// Running in to a wall check
		RaycastHit colliderHit;
		Ray colliderRay = new Ray (baseTank.position, baseTank.forward);
		
		if (Physics.Raycast (colliderRay, out colliderHit, 1)) {
			transform.Rotate (new Vector3 (0, 180, 0));
			moveScript.SetMovementSpeed (moveScript.GetMovementSpeed() * -1);
		}
		// End of wall check

		if (colliding > 0 && AItracks && AItracks.transform.FindChild(currentTrack.ToString())) {
			//Transform AItrack = AItracks.transform.GetChild(currentTrack);
			Transform AItrack = AItracks.transform.FindChild(currentTrack.ToString());

			moveScript.SetRotateSpeed (Vector3.Angle (AItrack.position - transform.position, transform.forward));
			moveScript.AddMovementSpeed (floatSpeed);

			if (Vector3.Distance (new Vector3(AItrack.position.x, transform.position.y, AItrack.position.z), transform.position) < 6f)
				AddCurrentTrack (1);
		} else if (AItracks)
			AddCurrentTrack (1);
	}
}

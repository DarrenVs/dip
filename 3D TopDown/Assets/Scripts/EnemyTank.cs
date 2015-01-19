using UnityEngine;
using System.Collections;

public class EnemyTank : MonoBehaviour {
	Transform baseTank;
	Transform turret;
	Transform barrle;
	
	public GameObject bulletPrefab;
	public float fireRate = 3;
	public GameObject AItrack;// Wip
	int currentTrack = 0;// Wip

	int colliding = 0;
	
	float cooldown;
	
	GameObject playerTank;
	
	// Use this for initialization
	void Start () {
		playerTank = GameObject.FindGameObjectWithTag ("Player");
		
		turret = transform.FindChild ("TankTurret");
		baseTank = transform.FindChild ("TankBase");
		barrle = turret.FindChild ("TurretBarrle");
		
		cooldown = fireRate;
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
		cooldown -= Time.deltaTime;

		if (playerTank) {
			RaycastHit viewHit;
			Ray viewRay = new Ray (turret.position, playerTank.transform.position - turret.position);
		
			if (cooldown <= 0 && Physics.Raycast (viewRay, out viewHit, 100)) {
				cooldown = fireRate;
				turret.LookAt (new Vector3 (playerTank.transform.position.x, turret.position.y, playerTank.transform.position.z));
				Instantiate (bulletPrefab, barrle.position + barrle.up * 0.5f, Quaternion.Euler (new Vector3 (0, turret.rotation.eulerAngles.y + 180, 0)));
			}
		}

		if (AItrack) {
			// Wip
		}
	}
}

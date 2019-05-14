using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class Move1 : MonoBehaviour
{

    private bool change = true;
    public float speed = 5.0f;

    void Update()
    {
        if (change)
            transform.Translate(Vector2.right * speed * Time.deltaTime);
        else
            transform.Translate(-Vector2.right * speed * Time.deltaTime);

        if (transform.position.x >= 10.0f || transform.position.z >= 10.0f)
        {
            change = false;
        }

        if (transform.position.x <= -10f || transform.position.z <= -10.0f)
        {
            change = true;
        }
    }
}

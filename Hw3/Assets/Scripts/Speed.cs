using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Speed : MonoBehaviour
{
    Renderer speed;

    // Start is called before the first frame update
    void Start()
    {
        speed = GetComponent<Renderer>();


        speed.material.shader = Shader.Find("Custom/NoiseExplosion");

    }

    // Update is called once per frame
    void Update()
    {

        speed.material.SetFloat("_DisplacementAmt", Input.mousePosition.x / 500);
      //  speed.material.SetFloat("_Strength", Input.mousePosition.y / 2000);

        //Debug.Log(Input.mousePosition.y);



    }

}

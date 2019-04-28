using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MousePosition : MonoBehaviour
{
    Renderer edge;
    Renderer blur;

    // Start is called before the first frame update
    void Start()
    {
       blur = GetComponent<Renderer>();
        edge = GetComponent<Renderer>();

        edge.material.shader = Shader.Find("Custom/Edge");
       
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.B))
        {
            blur.material.shader = Shader.Find("Custom/Blur");

        }
       
        if (Input.GetKeyDown(KeyCode.E))
        {
            edge.material.shader = Shader.Find("Custom/Edge");


        }
        blur.material.SetFloat("_Steps", Input.mousePosition.x / 100);
        edge.material.SetFloat("_Mix", Input.mousePosition.y / 200);

        //Debug.Log(Input.mousePosition.y);



    }
   
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CameraScreen : MonoBehaviour
{


        [SerializeField]
        [Range(1, 20)]
        private float speed = 5;
        private Vector2 rotation = Vector2.zero;
        public float mouse = 10;
   

        // Use this for initialization
        void Start()
        {
          
        }

        // Update is called once per frame
        void Update()
        {

            //movement- Use arrow keys
            Vector3 direction = Vector3.zero;


            if (Input.GetKey(KeyCode.W))
            {
                direction.z = 1;
              
            }
            if (Input.GetKey(KeyCode.S))
            {
                direction.z = -1;
               
            }
            if (Input.GetKey(KeyCode.D))
            {
                direction.x = 1;
   
            }
            if (Input.GetKey(KeyCode.A))
            {
                direction.x = -1;
              
            }

         
            transform.Translate(speed * direction.normalized * Time.deltaTime);



        }




      



}
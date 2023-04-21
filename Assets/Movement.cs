using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour
{
    void Start()
    {
        
    }

    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            gameObject.transform.position += new Vector3(0, 0, 1) * (Time.deltaTime * 4);
        }
        if (Input.GetKey(KeyCode.A))
        {
            gameObject.transform.position += new Vector3(-1, 0, 0) * (Time.deltaTime * 5);
        }
        if (Input.GetKey(KeyCode.S))
        {
            gameObject.transform.position += new Vector3(0, 0, -1) * (Time.deltaTime * 4);
        }
        if (Input.GetKey(KeyCode.D))
        {
            gameObject.transform.position += new Vector3(1, 0, 0) * (Time.deltaTime * 5);
        }
    }
}

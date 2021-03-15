using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CustomRoll : MonoBehaviour
{
    public float rollX = 0.0f;
    public float rollY = 0.0f;
    public float rollZ = 0.0f;
    // Start is called before the first frame update
    void Start()
    {
        //transform.Rotate(new Vector3(90, 60, 30));
        transform.Rotate(new Vector3(00, 00, 30));
        transform.Rotate(new Vector3(90, 00, 00));
        transform.Rotate(new Vector3(00, 60, 00));

        //transform.rotation = Quaternion.Euler(new Vector3(0, 90, 0));
    }

    // Update is called once per frame
    void Update()
    {

    }
}

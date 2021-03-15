using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Roll : MonoBehaviour
{
    public float rollSpeed = 10.0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
    }

    void OnTouched()
    {
        transform.Rotate(new Vector3(0, 1, 0), Time.deltaTime * rollSpeed);
    }
}

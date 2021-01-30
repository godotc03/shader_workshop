using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OffsetController : MonoBehaviour
{
    public float OffsetAmount;
    MeshRenderer meshRender;
    // Start is called before the first frame update
    void Start()
    {
        meshRender = GetComponent<MeshRenderer>();
    }

    // Update is called once per frame
    void Update()
    {
        OffsetAmount = Mathf.Lerp(OffsetAmount, 0, Time.deltaTime);
        meshRender.material.SetFloat("_Amount", OffsetAmount);
        if (Input.GetButtonDown("Jump"))
        {
            OffsetAmount += 1.0f;
        }
    }
}

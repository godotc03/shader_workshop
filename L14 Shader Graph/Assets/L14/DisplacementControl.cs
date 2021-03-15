using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DisplacementControl : MonoBehaviour
{
    public float displacementAmount;
    //MeshRenderer meshRender;
    SkinnedMeshRenderer skinnedMeshRender;
    // Start is called before the first frame update
    void Start()
    {
        //meshRender = GetComponent<MeshRenderer>();
        skinnedMeshRender = GetComponent<SkinnedMeshRenderer>();
    }

    // Update is called once per frame
    void Update()
    {
        displacementAmount = Mathf.Lerp(displacementAmount, 0, Time.deltaTime);
        //meshRender.material.SetFloat("_Amount", displacementAmount);
        skinnedMeshRender.material.SetFloat("_Amount", displacementAmount);
        if(Input.GetButtonDown("Jump"))
        {
            displacementAmount += 1.0f;
        }
    }
}

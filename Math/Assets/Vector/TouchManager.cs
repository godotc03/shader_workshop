using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TouchManager : MonoBehaviour
{
    public Camera cam;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButton(0))
        {
            bool isHit = Physics.Raycast(cam.ScreenPointToRay(Input.mousePosition), out RaycastHit hit, 100f);
            if (isHit)
            {
                hit.collider.gameObject.SendMessage("OnTouched", SendMessageOptions.DontRequireReceiver);
            }
        }
    }
}

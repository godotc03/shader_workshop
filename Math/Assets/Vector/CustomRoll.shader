
Shader "Unlit/CustomRoll"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Scale ("Scale", Vector) = (1.0, 1.0, 1.0)
        _Roll ("Roll", Vector) = (0.0, 0.0, 0.0)
        _Skew ("Skew", Vector) = (0.0, 0.0, 0.0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque"}
        LOD 100
        Cull Off
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float3 _Roll;
            float3 _Scale;
            float3 _Skew;
            
            //
            
            float4 customTransform(float4 vertex)
            {
                float4x4 mt_Scale;
                
                mt_Scale[0]= float4(_Scale.x, 0.0f, 0.0f, 0.0f);
                mt_Scale[1]= float4(0.0f, _Scale.y, 0.0f, 0.0f);
                mt_Scale[2]= float4(0.0f, 0.0f, _Scale.z, 0.0f);
                mt_Scale[3]= float4(0.0f, 0.0f, 0.0f,     1.0f);
                
                float4x4 mt_Roll;
                //x roll
                mt_Roll[0]= float4(1.0f, 0.0f, 0.0f, 0.0f);
                mt_Roll[1]= float4(0.0f, cos(_Roll.x), -sin(_Roll.x), 0.0f);
                mt_Roll[2]= float4(0.0f, sin(_Roll.x), cos(_Roll.x), 0.0f);
                mt_Roll[3]= float4(0.0f, 0.0f, 0.0f, 1.0f);
                
                //y pitch
                //mt_Roll[0]= float4(cos(_Roll.y),  0.0f, sin(_Roll.y),  0.0f);
                //mt_Roll[1]= float4(0.0f,          1.0f, 0.0f,          0.0f);
                //mt_Roll[2]= float4(-sin(_Roll.y), 0.0f, cos(_Roll.y),  0.0f);
                //mt_Roll[3]= float4(0.0f,          0.0f, 0.0f,          1.0f);
                
                //z yaw
                //mt_Roll[0]= float4(cos(_Roll.z),    sin(_Roll.z),   0.0f, 0.0f);
                //mt_Roll[1]= float4(-sin(_Roll.z),   cos(_Roll.z),   0.0f, 0.0f);
                //mt_Roll[2]= float4(0.0f,            0.0f,           1.0f, 0.0f);
                //mt_Roll[3]= float4(0.0f,            0.0f,           0.0f, 1.0f);
                float4x4 mt;
                //mt = mul(mt_Roll , mt_Scale); 
                mt = mt_Scale;
                return mul(mt, vertex);
            }
            //worldSpacePos=mul(unity_ObjectToWorld, objSpacePos);
            //viewSpacePos=mul(UNITY_MATRIX_V, worldSpacePos);
            //clipSpacePos=mul(UNITY_MATRIX_P, viewSpacePos);
            //clipSpacePos=mul(UNITY_MATRIX_MVP, objSpacePos);
            
            v2f vert (appdata v)
            {
                v2f o;
                float4 pos1 = customTransform(float4(v.vertex.xyz,1.0f));
                o.vertex = UnityObjectToClipPos(pos1);
                //o.vertex = mul(UNITY_MATRIX_MVP,o.vertex);  //unity5.6以前的写法  

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}

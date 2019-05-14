//Followed the tutorial on catlikecoding for distortion
Shader "Custom/Distortion"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        [NoScaleOffset] _FlowMap ("Flow (RG, A noise)", 2D) = "black" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _UJump ("U Jump", Range(-0.50,0.50)) = 0.50
        _VJump ("V Jump", Range(-0.50,0.50)) = 0.50
        _Tiling ("Tile", Float) =1
        _Rate ("Rate", Float) =1
        _Strength ("Strength", Float)=1
        [NoScaleOffset] _Normal ("Normals", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
        #include "Flow.cginc"
        
        sampler2D _MainTex, _FlowMap, _Normal;
        float _UJump, _VJump, _Strength;
        float _Tiling, _Rate;
       // float _FlowOffset;

        struct Input
        {
            float2 uv_MainTex;
        };
        
      
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 flowVector = _Strength;
            float noise = tex2D(_FlowMap, IN.uv_MainTex).a;
            float time = _Time.y *_Rate + noise;
            //alternate between two cycles to loop at anywhere from 0-16 seconds
            float2 jump = float2(_UJump, _VJump);
            
                // Albedo comes from a texture tinted by color
            //float3 uvw = FlowUVW(IN.uv_MainTex, flowVector, time);
           // fixed4 c = tex2D (_MainTex , uvw.xy) * uvw.z * _Color;
            
            //Flow applied to two textures so the height is always equal to 1
            float3 uvwA = FlowUVW(IN.uv_MainTex, flowVector, jump,_Tiling, time, false);
            float3 uvwB = FlowUVW(IN.uv_MainTex,flowVector, jump,_Tiling, time, true);
            
            //normal texture sample for A and B
            float3 normalA = UnpackNormal(tex2D(_Normal, uvwA.xy)) * uvwA.z;
             float3 normalB = UnpackNormal(tex2D(_Normal, uvwB.xy)) * uvwA.z;
             o.Normal = normalize(normalA + normalB);
             
              //Oscillate between two textures so the height is always equal to 1
            fixed4 texA = tex2D(_MainTex, uvwA.xy) * uvwA.z;
            fixed4 texB = tex2D(_MainTex, uvwB.xy) * uvwB.z;
            
            fixed4 c = (texA + texB) * _Color;
           
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}

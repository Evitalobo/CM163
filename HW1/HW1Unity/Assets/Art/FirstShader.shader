// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/FirstShader"
{
    Properties
    {
        _Color ("My Custom Color", Color) = (1,1,1,1)
       
    }
    
    SubShader
    {
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            //variables
            float4 _Color;
            
            
            
            struct vertexShaderInput
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };
            
            struct vertexShaderOutput
            {
                float2 uv: TEXCOORD0;
                float4 pos: SV_POSITION;
            };
            
            sampler2D _MainTex;
  
            
            vertexShaderOutput vert(vertexShaderInput v)
            {
                vertexShaderOutput o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }
            
            float4 frag(vertexShaderOutput i): SV_TARGET
            {
                float4 col = tex2D(_MainTex,i.uv);
                return _Color;
            }
            
            
            ENDCG
        }
        
    }
    
}

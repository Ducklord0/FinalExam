Shader "Custom/Lec2"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
    }
    SubShader{
        Tags { "LightMode" = "ForwardBase" }
        Pass{
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        //#pragma surface surf Lambert
        #pragma vertex vert
        #pragma fragment frag

        uniform float4 _Color;
        uniform float4 _LightColor0;

        struct vertexInput {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
        };

        struct vertexOutput {
            float4 pos: SV_POSITION;
            float4 col: COLOR;
        };

        vertexOutput vert(vertexInput v) {
            vertexOutput o;
            float3 normalDirection = normalize(mul(float4(v.normal, 0.0), unity_WorldToObject).xyz);
            float3 lightDirection;
            float atten = 1.0;
            lightDirection = normalize(_WorldSpaceLightPos0.xyz);
            float3 diffuseReflection = atten
                * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));
            o.col = float4(diffuseReflection, 1.0);
            o.pos = UnityObjectToClipPos(v.vertex);
            return o;
        }
        float frag(vertexOutput i) : COLOR
        {
               return i.col;
        }
        ENDCG
       }
    }
}
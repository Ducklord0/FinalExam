Shader "Custom/AdvancedOutlineShader"
{
    Properties
    {
        _Outline("Outline Width", Range(0.002,0.1)) = 0.005
        _OutlineColor("Outline Color", Color) = (0,0,0,1)
        _MainTex("Texture", 2D) = "white" {}
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

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
            Pass{
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
        struct appdata {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
};
        struct v2f {
            float4 pos : SV_POSITION;
            fixed4 color : COLOR;
            };
        float _Outline;
        float4 _OutlineColor;

        v2f vert(appdata v) {
            v2f o;
            o.pos = UnityObjectToClipPos(v.vertex);

            float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV,v.normal));
            float2 offset = TransformViewToProjection(norm.xy);

            o.pos.xy += offset * o.pos.z * _Outline;
            o.color = _OutlineColor;
            return o;
        }
        fixed4 frag(v2f i) : SV_Target{
            return i.color;
        }
            ENDCG
        }
    }
    FallBack "Diffuse"
}

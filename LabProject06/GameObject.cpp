#include "stdafx.h"
#include "GameObject.h"
#include "Shader.h"

CGameObject::CGameObject()
{
	XMStoreFloat4x4(&m_xmf4x4World, XMMatrixIdentity());
}

void CGameObject::SetShader(std::shared_ptr<CShader> pShader)
{
	if (m_pShader) m_pShader.reset();
	m_pShader = pShader;
}

void CGameObject::SetMesh(std::shared_ptr<CMesh> pMesh)
{
	if (m_pMesh) m_pMesh.reset();
	m_pMesh = pMesh;
}

void CGameObject::ReleaseUploadBuffers()
{
	// 정점 버퍼를 위한 업로드 버퍼를 소멸시킨다. 
	if (m_pMesh) m_pMesh->ReleaseUploadBuffers();
}

void CGameObject::Animate(float fTimeElapsed)
{

}

void CGameObject::OnPrepareRender()
{

}

void CGameObject::Render(ID3D12GraphicsCommandList* pd3dCommandList)
{
	OnPrepareRender();
	
	// 게임 객체에 셰이더 객체가 연결되어 있으면 셰이더 상태 객체를 설정한다. 
	if (m_pShader) m_pShader->Render(pd3dCommandList);

	// 게임 객체에 메쉬가 연결되어 있으면 메쉬를 렌더링한다. 
	if (m_pMesh) m_pMesh->Render(pd3dCommandList);
}

CGameObject::~CGameObject()
{
	if (m_pShader) {
		m_pShader->ReleaseShaderVariables();
	}
}
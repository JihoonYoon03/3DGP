#pragma once

#include "Timer.h"

class CScene
{
public:
	CScene();
	~CScene();

	bool OnProcessingMouseMessage(HWND hWnd, UINT nMessageID, WPARAM wParam, LPARAM lParam);
	bool OnProcessingKeyboardMessage(HWND hWnd, UINT nMessageID, WPARAM wParam, LPARAM lParam);

	void CreateGraphicsRootSignature(ID3D12Device* pd3dDevice);
	void CreateGraphicsPipelineState(ID3D12Device* pd3dDevice);

	void BuildObjects(ID3D12Device* pd3dDevice);

	bool ProcessInput();
	void AnimateObjects(float fTimeElapsed);

	void PrepareRender(ID3D12GraphicsCommandList* pd3dCommandList);
	void Render(ID3D12GraphicsCommandList* pd3dCommandList);

	// 루트 시그너쳐를 나타내는 인터페이스 포인터이다. 
	// Root Signature - GPU 파이프라인과 데이터 사이의 통로, 계약서
	// 셰이더 실행 시 어떤 종류의 데이터를 어떤 슬롯에 넘겨받을 것인지 정의.
	// GPU가 읽을 데이터의 목차임.
	// Root Parameter - DescriptorTable(DescHeap의 집합), Rood Descriptor(CBV), Root Constant(상수)
	// DescTable - 셰이더가 DescHeap에서의 어디서부터 어디까지 읽어들일지 범위 지정
	ComPtr<ID3D12RootSignature> m_pd3dGraphicsRootSignature;

	// 파이프라인 상태를 나타내는 인터페이스 포인터이다.
	ComPtr<ID3D12PipelineState> m_pd3dPipelineState;
};
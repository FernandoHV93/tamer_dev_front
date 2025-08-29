import { useState } from "react";
import * as api from "../../services/brandVoice";

type ViewMode = "main" | "upload" | "paste";

export default function ContentAnalysis({ sessionId, userId, showToast }) {
  const [text, setText] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [loading, setLoading] = useState(false);
  const [viewMode, setViewMode] = useState<ViewMode>("main");

  async function handleText() {
    setLoading(true);
    try {
      const res = await api.analyzeContent(sessionId, userId, text);
      showToast("Content analyzed!", "success");
      console.log(res);
    } catch (e: any) {
      showToast(e?.message ?? String(e), "error");
    } finally {
      setLoading(false);
    }
  }

  async function handleFile() {
    if (!file) return;
    setLoading(true);
    try {
      const res = await api.analyzeFile(sessionId, userId, file);
      showToast("File analyzed!", "success");
      console.log(res);
    } catch (e: any) {
      showToast(e?.message ?? String(e), "error");
    } finally {
      setLoading(false);
    }
  }

  function handleFileChange(e: React.ChangeEvent<HTMLInputElement>) {
    const selectedFile = e.target.files?.[0] ?? null;
    setFile(selectedFile);
    
    // Auto-submit when a file is selected
    if (selectedFile) {
      handleFile();
    }
  }

  function handleBack() {
    setViewMode("main");
  }

  // Main view with two options
  if (viewMode === "main") {
    return (
      <div className="bg-gradient-to-br from-gray-900 to-gray-950 p-6 sm:rounded-xl border border-gray-700 w-full">
        <h2 className="text-lg font-semibold mb-6 text-start">Content Analysis</h2>
        <div className="grid grid-rows-2 sm:grid-rows-none sm:grid-cols-2 gap-6">
          {/* Upload Document Card */}
          <div 
            className="p-6 rounded-xl border border-gray-700 hover:border-blue-400 transition cursor-pointer flex flex-col items-center justify-center text-center"
            onClick={() => setViewMode("upload")}
          >
            <div className="mb-4">
              <svg className="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path>
              </svg>
            </div>
            <h3 className="font-semibold mb-2">Upload Document</h3>
            <p className="text-sm text-gray-400">Upload your content in PDF, DOC, DOCX, or TXT format.</p>
          </div>

          {/* Paste Text Card */}
          <div 
            className="p-6 rounded-xl border border-gray-700 hover:border-blue-400 transition cursor-pointer flex flex-col items-center justify-center text-center"
            onClick={() => setViewMode("paste")}
          >
            <div className="mb-4">
              <svg className="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"></path>
              </svg>
            </div>
            <h3 className="font-semibold mb-2">Paste Text</h3>
            <p className="text-sm text-gray-400">Copy and paste your content directly into a text field.</p>
          </div>
        </div>
      </div>
    );
  }

  // Upload document view
  if (viewMode === "upload") {
    return (
      <div className="bg-gradient-to-br from-gray-900 to-gray-950 p-8 sm:rounded-xl border border-gray-700 w-[100vw] sm:w-full">
        <h2 className="text-lg font-semibold mb-6 text-start">Content Analysis</h2>
        
        <div className="border-2 border-dashed border-gray-600 rounded-lg p-8 text-center">
          <div className="mb-4">
            <svg className="w-16 h-16 text-gray-400 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path>
            </svg>
          </div>
          <p className="text-lg mb-2">Drag and drop your file here</p>
          <p className="text-gray-400 mb-4">or</p>
          
          <label htmlFor="file-upload" className="cursor-pointer bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">
            Browse Files
          </label>
          <input 
            id="file-upload"
            type="file" 
            className="hidden"
            onChange={handleFileChange}
            accept=".pdf,.doc,.docx,.txt"
          />
          
          <p className="text-sm text-gray-400 mt-4">Supports PDF, DOC, DOCX, and TXT files</p>
        </div>

        <div className="mt-6 flex justify-start">
          <button 
            onClick={handleBack}
            className="text-gray-400 hover:text-white flex items-center"
          >
            <svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
            </svg>
            Back
          </button>
        </div>
      </div>
    );
  }

  // Paste text view
  if (viewMode === "paste") {
    return (
      <div className="bg-gradient-to-br from-gray-900 to-gray-950 p-8 sm:rounded-xl border border-gray-700 w-[100vw] sm:w-full">
        <h2 className="text-lg font-semibold mb-6 text-start">Content Analysis</h2>
        
        <div className="mb-4">
          <textarea
            className="w-full h-60 p-4 rounded-lg bg-[#111317] border border-gray-700 focus:border-blue-500 focus:outline-none"
            value={text}
            onChange={(e) => setText(e.target.value)}
            placeholder="Paste your content here..."
          />
        </div>
        
        <div className="flex justify-between items-center">
          <button 
            onClick={handleBack}
            className="text-gray-400 hover:text-white flex items-center"
          >
            <svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
            </svg>
            Back
          </button>
          
          <button
            onClick={handleText}
            disabled={!text || loading}
            className="bg-blue-600 hover:bg-blue-700 disabled:bg-blue-800 disabled:opacity-50 text-white px-4 py-2 rounded-md"
          >
            {loading ? "Analyzing..." : "Analyze Content"}
          </button>
        </div>
      </div>
    );
  }

  return null;
}
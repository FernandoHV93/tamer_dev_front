import { useEffect, useState } from "react";
import { useSession } from "../context/SessionContext";
import { useToast } from "../context/ToastContext";

// Components
import PageHeader from "../components/brandVoice/PageHeader";
import ChooseMethod from "../components/brandVoice/ChooseMethod";
import MethodRenderer from "../components/brandVoice/MethodRenderer";
import SavedBrandVoices from "../components/brandVoice/SavedBrandVoice";
import BrandVoicePreview from "../components/brandVoice/BrandVoicePreview";

// Hooks
import useBrands, { type BrandVoiceData } from "../hooks/useBrands";

export default function BrandVoicePage() {
  const { sessionId, userId } = useSession();
  const { showToast } = useToast();

  const [method, setMethod] = useState<"deep" | "analysis" | null>(null);
  const [showCreateForm, setShowCreateForm] = useState(false);

  const { brands, loading, load, addBrand, deleteBrand } = useBrands(sessionId, userId, showToast);

  useEffect(() => {
    load();
  }, []);

  const handleAddBrand = async (brandData: BrandVoiceData) => {
    const success = await addBrand(brandData);
    if (success) {
      setShowCreateForm(false);
    }
  };

  const handleDeleteBrand = async (id: string) => {
    await deleteBrand(id);
  };

  const handleEditBrand = (brand: any) => {
    // Implementar la lógica de edición según tu API
    showToast("Edit functionality to be implemented", "info");
  };

  const handleCreateNew = () => {
    setShowCreateForm(true);
  };

  return (
    <div className="min-h-screen bg-[#0f1116] text-white sm:p-8 flex flex-col items-center">
      <PageHeader title="Brand Voice" />

      <ChooseMethod method={method} setMethod={setMethod} />

      <div className="w-[100vw] sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <MethodRenderer 
          method={method} 
          sessionId={sessionId} 
          userId={userId} 
          showToast={showToast} 
        />
      </div>

      <div className="w-[100vw] sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
        <SavedBrandVoices
          brands={brands}
          onEdit={handleEditBrand}
          onDelete={handleDeleteBrand}
          onCreateNew={handleCreateNew}
          isLoading={loading}
        />
      </div>

      {showCreateForm && (
        <div className="w-[100vw] sm:w-[80%] lg:w-[62%] mb-8 max-w-[1200px]">
          <BrandVoicePreview
            onAddBrand={handleAddBrand}
            isLoading={loading}
          />
        </div>
      )}
    </div>
  );
}
import { useState } from 'react';

interface BrandVoice {
  id: string;
  brandName: string;
  toneOfVoice: string;
  keyValues: string[];
  targetAudience: string;
}

interface SavedBrandVoicesProps {
  brands: BrandVoice[];
  onEdit?: (brand: BrandVoice) => void;
  onDelete?: (id: string) => void;
  onCreateNew?: () => void;
  isLoading?: boolean;
}

export default function SavedBrandVoices({ 
  brands = [], 
  onEdit, 
  onDelete, 
  onCreateNew,
  isLoading = false 
}: SavedBrandVoicesProps) {
  const [expandedBrand, setExpandedBrand] = useState<string | null>(null);

  const toggleExpand = (id: string) => {
    if (expandedBrand === id) {
      setExpandedBrand(null);
    } else {
      setExpandedBrand(id);
    }
  };

  if (isLoading) {
    return (
      <div className="bg-gradient-to-br from-gray-900 to-gray-950 sm:rounded-xl border border-gray-700 p-6  mx-auto">
        <h1 className="text-2xl font-bold mb-6">Saved Brand Voices</h1>
        <div className="flex justify-center items-center h-40">
          <div className="animate-pulse text-gray-400">Loading brand voices...</div>
        </div>
      </div>
    );
  }

  return (
    <div className="bg-gradient-to-br from-gray-900 to-gray-950 sm:rounded-xl border border-gray-700 p-6  mx-auto">
      <h1 className="text-2xl font-bold mb-6">Saved Brand Voices</h1>

      {brands.length > 0 ? (
        <>
          {/* Table for larger screens */}
          <div className="hidden md:block overflow-x-auto">
            <table className="w-full border-collapse">
              <thead>
                <tr className="border-b border-gray-700">
                  <th className="text-left py-3 px-4 font-semibold">Brand Name</th>
                  <th className="text-left py-3 px-4 font-semibold">Tone of Voice</th>
                  <th className="text-left py-3 px-4 font-semibold">Key Values</th>
                  <th className="text-left py-3 px-4 font-semibold">Audience</th>
                  <th className="text-left py-3 px-4 font-semibold">Actions</th>
                </tr>
              </thead>
              <tbody>
                {brands.map((brand) => (
                  <tr key={brand.id} className="border-b border-gray-700 hover:bg-[#111317] transition">
                    <td className="py-3 px-4">{brand.brandName}</td>
                    <td className="py-3 px-4">{brand.toneOfVoice}</td>
                    <td className="py-3 px-4">
                      <div className="flex flex-wrap gap-1">
                        {brand.keyValues.slice(0, 2).map((value, index) => (
                          <span key={index} className="bg-blue-900 text-blue-200 text-xs px-2 py-1 rounded">
                            {value}
                          </span>
                        ))}
                        {brand.keyValues.length > 2 && (
                          <span className="text-gray-400 text-xs">
                            +{brand.keyValues.length - 2} more
                          </span>
                        )}
                      </div>
                    </td>
                    <td className="py-3 px-4">{brand.targetAudience}</td>
                    <td className="py-3 px-4">
                      <div className="flex space-x-2">
                        {onEdit && (
                          <button
                            onClick={() => onEdit(brand)}
                            className="text-blue-400 hover:text-blue-300 text-sm"
                          >
                            Edit
                          </button>
                        )}
                        {onDelete && (
                          <button
                            onClick={() => onDelete(brand.id)}
                            className="text-red-400 hover:text-red-300 text-sm"
                          >
                            Delete
                          </button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* Cards for mobile screens */}
          <div className="md:hidden space-y-4">
            {brands.map((brand) => (
              <div key={brand.id} className="border border-gray-700 rounded-lg p-4">
                <div 
                  className="flex justify-between items-start cursor-pointer"
                  onClick={() => toggleExpand(brand.id)}
                >
                  <div>
                    <h3 className="font-semibold">{brand.brandName}</h3>
                    <p className="text-sm text-gray-400">{brand.toneOfVoice}</p>
                  </div>
                  <div className="flex space-x-2">
                    {onEdit && (
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          onEdit(brand);
                        }}
                        className="text-blue-400 hover:text-blue-300 text-sm"
                      >
                        Edit
                      </button>
                    )}
                    {onDelete && (
                      <button
                        onClick={(e) => {
                          e.stopPropagation();
                          onDelete(brand.id);
                        }}
                        className="text-red-400 hover:text-red-300 text-sm"
                      >
                        Delete
                      </button>
                    )}
                  </div>
                </div>
                
                {expandedBrand === brand.id && (
                  <div className="mt-3 pt-3 border-t border-gray-700">
                    <div className="mb-2">
                      <span className="text-sm font-medium text-gray-400">Key Values:</span>
                      <div className="flex flex-wrap gap-1 mt-1">
                        {brand.keyValues.map((value, index) => (
                          <span key={index} className="bg-blue-900 text-blue-200 text-xs px-2 py-1 rounded">
                            {value}
                          </span>
                        ))}
                      </div>
                    </div>
                    <div>
                      <span className="text-sm font-medium text-gray-400">Audience:</span>
                      <p className="text-sm mt-1">{brand.targetAudience}</p>
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        </>
      ) : (
        /* Empty state */
        <div className="text-center py-10">
          <div className="border-t border-gray-700 my-6"></div>
          <h2 className="text-xl font-semibold mb-4">No Brand Voices Yet</h2>
          <p className="text-gray-400 mb-6 max-w-md mx-auto">
            Create your first brand voice to establish a consistent tone across all your content.
          </p>
          {onCreateNew && (
            <button
              onClick={onCreateNew}
              className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-md font-medium inline-flex items-center"
            >
              <span>Create Your First Brand Voice</span>
              <svg className="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
              </svg>
            </button>
          )}
        </div>
      )}
    </div>
  );
}
import { useState } from 'react';
import * as api from '../services/brandVoice';

export interface SavedBrand {
  id: string;
  brandName: string;
  toneOfVoice: string;
  keyValues: string[];
  targetAudience: string;
  brandIdentityInsights?: string;
}

export interface BrandVoiceData {
  brandName: string;
  toneOfVoice: string;
  keyValues: string[];
  targetAudience: string;
  brandIdentityInsights: string;
}

import type { ToastType } from '../context/ToastContext';

export default function useBrands(sessionId: string, userId: string, showToast: (message: string, type?: ToastType, ttlMs?: number) => void) {
  const [brands, setBrands] = useState<SavedBrand[]>([]);
  const [loading, setLoading] = useState(false);

  const load = async () => {
    setLoading(true);
    try {
      const list = await api.listBrands(sessionId, userId);
      const adaptedBrands: SavedBrand[] = list.map(brand => ({
        id: brand.id,
        brandName: brand.brandName,
        toneOfVoice: brand.toneOfVoice || "",
        keyValues: Array.isArray(brand.keyValues) ? brand.keyValues : [],
        targetAudience: brand.targetAudience || "",
        brandIdentityInsights: brand.brandIdentityInsights || ""
      }));
      setBrands(adaptedBrands);
    } catch (e: any) {
      showToast(e?.message ?? String(e), "error");
    } finally {
      setLoading(false);
    }
  };

  const addBrand = async (brandData: BrandVoiceData) => {
    setLoading(true);
    try {
      await api.addBrand(sessionId, userId, brandData);
      showToast("Brand added successfully!", "success");
      await load();
      return true;
    } catch (e: any) {
      showToast(e?.message ?? String(e), "error");
      return false;
    } finally {
      setLoading(false);
    }
  };

  const deleteBrand = async (id: string) => {
    setLoading(true);
    try {
      await api.deleteBrand(sessionId, userId, id);
      showToast("Brand deleted successfully!", "success");
      await load();
      return true;
    } catch (e: any) {
      showToast(e?.message ?? String(e), "error");
      return false;
    } finally {
      setLoading(false);
    }
  };

  return {
    brands,
    loading,
    load,
    addBrand,
    deleteBrand
  };
}
import { useState } from 'react'
import { useSession } from '../context/SessionContext'
import { useToast } from '../context/ToastContext'
import * as api from '../services/apiSettings'
import { Card, CardContent } from '../components/ui/card'
import { Button } from '../components/ui/button'
import { Input } from '../components/ui/input'
import { Badge } from '../components/ui/badge'
import { Eye, EyeOff, Check, X } from 'lucide-react'

interface ProviderData {
  name: string
  displayName: string
  description: string
  logo: string
  logoColor: string
  features: string[]
  apiKey: string
  isConnected: boolean
}

export default function ApiSettingsPage() {
  const { sessionId, userId } = useSession()
  const { showToast } = useToast()
  
  const [providers, setProviders] = useState<ProviderData[]>([
    {
      name: 'grok',
      displayName: 'Grok',
      description: 'Connect to Tesla\'s Grok AI for cutting-edge language processing and real-time analysis.',
      logo: 'M',
      logoColor: 'text-white',
      features: [
        'Real-time data integration',
        'Advanced reasoning with current context',
        'Witty and informative responses',
        'Tesla-grade AI capabilities'
      ],
      apiKey: '',
      isConnected: false
    },
    {
      name: 'openai',
      displayName: 'OpenAI GPT-4',
      description: 'Connect to OpenAI\'s GPT-4 for state-of-the-art language processing and content generation.',
      logo: '🌸',
      logoColor: 'text-white',
      features: [
        'Advanced text generation and completion',
        'Natural language understanding',
        'Content summarization and expansion',
        'Multiple language support'
      ],
      apiKey: '',
      isConnected: false
    },
    {
      name: 'anthropic',
      displayName: 'Anthropic Claude',
      description: 'Integrate with Anthropic\'s Claude for enhanced AI capabilities and sophisticated content generation.',
      logo: '⭐',
      logoColor: 'text-orange-400',
      features: [
        'Advanced reasoning capabilities',
        'Longer context understanding',
        'Nuanced content generation',
        'Improved factual accuracy'
      ],
      apiKey: '',
      isConnected: false
    },
    {
      name: 'perplexity',
      displayName: 'Perplexity',
      description: 'Connect to Perplexity AI for advanced language understanding and generation.',
      logo: '🔷',
      logoColor: 'text-teal-400',
      features: [
        'State-of-the-art language models',
        'Advanced reasoning capabilities',
        'Contextual understanding',
        'High accuracy responses'
      ],
      apiKey: '',
      isConnected: false
    }
  ])

  const [showApiKeys, setShowApiKeys] = useState<{ [key: string]: boolean }>({
    grok: false,
    openai: false,
    anthropic: false,
    perplexity: false
  })

  const toggleApiKeyVisibility = (providerName: string) => {
    setShowApiKeys(prev => ({
      ...prev,
      [providerName]: !prev[providerName]
    }))
  }

  const updateApiKey = (providerName: string, value: string) => {
    setProviders(prev => prev.map(provider => 
      provider.name === providerName 
        ? { ...provider, apiKey: value }
        : provider
    ))
  }

  const handleConnect = async (provider: ProviderData) => {
    if (!provider.apiKey.trim()) {
      showToast('Please enter an API key', 'error')
      return
    }

    try {
      await api.connectProvider(sessionId, userId, provider.apiKey, provider.name)
      setProviders(prev => prev.map(p => 
        p.name === provider.name 
          ? { ...p, isConnected: true }
          : p
      ))
      showToast(`${provider.displayName} connected successfully`, 'success')
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    }
  }

  const handleDisconnect = async (provider: ProviderData) => {
    try {
      await api.disconnectProvider(sessionId, userId, provider.name)
      setProviders(prev => prev.map(p => 
        p.name === provider.name 
          ? { ...p, isConnected: false, apiKey: '' }
          : p
      ))
      showToast(`${provider.displayName} disconnected successfully`, 'success')
    } catch (e: any) {
      showToast(e?.message ?? String(e), 'error')
    }
  }

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <div className="container mx-auto px-6 py-8 max-w-6xl">
        {/* Header Section */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-100 mb-2">API Settings</h1>
          <p className="text-gray-400 text-lg">
            Connect your AI API keys to unlock advanced AI capabilities.
          </p>
        </div>

        {/* AI Provider Sections */}
        <div className="space-y-6">
          {providers.map((provider) => (
            <Card key={provider.name} className="bg-gray-800 border-gray-700">
              <CardContent className="p-6">
                <div className="flex flex-col lg:flex-row gap-6">
                  {/* Left Side - Provider Info */}
                  <div className="flex-1 space-y-4">
                    {/* Provider Header */}
                    <div className="flex items-start justify-between">
                      <div className="flex items-center gap-3">
                        <div className={`w-10 h-10 bg-gray-700 rounded-lg flex items-center justify-center text-xl font-bold ${provider.logoColor}`}>
                          {provider.logo}
                        </div>
                        <div>
                          <h3 className="text-xl font-semibold text-gray-100">
                            {provider.displayName}
                          </h3>
                          <p className="text-gray-400 text-sm max-w-md">
                            {provider.description}
                          </p>
                        </div>
                      </div>
                      
                      {/* Status Badge */}
                      <Badge 
                        className={`${
                          provider.isConnected 
                            ? 'bg-green-600 text-white border-green-600' 
                            : 'bg-white text-gray-800 border-white'
                        }`}
                      >
                        {provider.isConnected ? 'Connected' : 'Disconnected'}
                      </Badge>
                    </div>

                    {/* API Key Link */}
                    <div className="flex justify-end">
                      <a 
                        href="#" 
                        className="text-blue-400 hover:text-blue-300 text-sm flex items-center gap-1"
                        onClick={(e) => {
                          e.preventDefault()
                          showToast('Learn how to get your API key - Link to be implemented', 'info')
                        }}
                      >
                        Learn how to get your API key →
                      </a>
                    </div>

                    {/* API Key Input */}
                    <div className="space-y-2">
                      <label className="block text-sm font-medium text-gray-300">
                        API Key
                      </label>
                      <div className="relative">
                        <Input
                          type={showApiKeys[provider.name] ? 'text' : 'password'}
                          placeholder="Enter your API key"
                          value={provider.apiKey}
                          onChange={(e) => updateApiKey(provider.name, e.target.value)}
                          className="bg-gray-700 border-gray-600 text-white placeholder:text-gray-400 pr-10"
                        />
                        <button
                          type="button"
                          onClick={() => toggleApiKeyVisibility(provider.name)}
                          className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-300"
                        >
                          {showApiKeys[provider.name] ? (
                            <EyeOff className="w-4 h-4" />
                          ) : (
                            <Eye className="w-4 h-4" />
                          )}
                        </button>
                      </div>
                    </div>

                    {/* Connect/Disconnect Button */}
                    <div className="pt-2">
                      {provider.isConnected ? (
                        <Button
                          variant="outline"
                          onClick={() => handleDisconnect(provider)}
                          className="border-gray-600 text-gray-300 hover:bg-gray-700 hover:text-white"
                        >
                          Disconnect
                        </Button>
                      ) : (
                        <Button
                          onClick={() => handleConnect(provider)}
                          className="bg-blue-600 hover:bg-blue-700 text-white"
                        >
                          Connect
                        </Button>
                      )}
                    </div>
                  </div>

                  {/* Right Side - Features */}
                  <div className="lg:w-80">
                    <h4 className="text-sm font-semibold text-gray-300 mb-3">Features</h4>
                    <div className="space-y-2">
                      {provider.features.map((feature, index) => (
                        <div key={index} className="flex items-center gap-2">
                          <div className="w-4 h-4 bg-blue-600 rounded-full flex items-center justify-center">
                            <Check className="w-3 h-3 text-white" />
                          </div>
                          <span className="text-sm text-gray-400">{feature}</span>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* API Usage Guidelines Section */}
        <div className="mt-8">
          <Card className="bg-gray-800 border-gray-700">
            <CardContent className="p-6">
              <h3 className="text-xl font-semibold text-gray-100 mb-4">API Usage Guidelines</h3>
              <p className="text-gray-400 text-sm mb-6 leading-relaxed">
                Your API keys are stored securely in your browser's local storage and are only used to authenticate requests to the respective services. We never store or share your API keys with third parties.
              </p>
              
              <div className="space-y-3">
                <div className="flex items-start gap-3">
                  <div className="w-5 h-5 bg-blue-600 rounded-full flex items-center justify-center mt-0.5">
                    <Check className="w-3 h-3 text-white" />
                  </div>
                  <span className="text-sm text-gray-400">
                    API requests are made directly from your browser to the AI providers, ensuring maximum security.
                  </span>
                </div>
                
                <div className="flex items-start gap-3">
                  <div className="w-5 h-5 bg-blue-600 rounded-full flex items-center justify-center mt-0.5">
                    <Check className="w-3 h-3 text-white" />
                  </div>
                  <span className="text-sm text-gray-400">
                    You maintain full control over your API usage and can disconnect at any time.
                  </span>
                </div>
                
                <div className="flex items-start gap-3">
                  <div className="w-5 h-5 bg-red-600 rounded-full flex items-center justify-center mt-0.5">
                    <X className="w-3 h-3 text-white" />
                  </div>
                  <span className="text-sm text-gray-400">
                    Never share your API keys with others or expose them in public repositories.
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  )
}


